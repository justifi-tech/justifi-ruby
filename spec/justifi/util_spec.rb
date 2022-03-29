# frozen_string_literal: true

RSpec.describe Justifi::Util do
  describe "#encode_parameters" do
    context "should prepare parameters for an HTTP request" do
      it do
        params = {
          a: 3,
          b: "+foo?",
          c: "bar&baz",
          d: {a: "a", b: "b"},
          e: [0, 1],
          f: "",

          # empty array won't even show up in the request
          g: []
        }
        expect(subject.encode_parameters(params)).to eq(
          "a=3&b=%2Bfoo%3F&c=bar%26baz&d[a]=a&d[b]=b&e[0]=0&e[1]=1&f="
        )
      end
    end
  end

  describe "#url_encode" do
    context "should prepare strings for HTTP" do
      it do
        expect(subject.url_encode("foo")).to eq "foo"
        expect(subject.url_encode(:foo)).to eq "foo"
        expect(subject.url_encode("foo+")).to eq "foo%2B"
        expect(subject.url_encode("foo&")).to eq "foo%26"
        expect(subject.url_encode("foo[bar]")).to eq "foo[bar]"
      end
    end
  end

  describe "#flatten_params" do
    context "should encode parameters according to Rails convention" do
      it do
        params = [
          [:a, 3],
          [:b, "foo?"],
          [:c, "bar&baz"],
          [:d, {a: "a", b: "b"}],
          [:e, [0, 1]],
          [:f, [
            {foo: "1", ghi: "2"},
            {foo: "3", bar: "4"}
          ]],
          [:g, [[0, 1]]]
        ]
        expect([
          ["a", 3],
          ["b", "foo?"],
          ["c", "bar&baz"],
          ["d[a]", "a"],
          ["d[b]", "b"],
          ["e[0]", 0],
          ["e[1]", 1],

          ["f[0][foo]", "1"],
          ["f[0][ghi]", "2"],
          ["f[1][foo]", "3"],
          ["f[1][bar]", "4"],
          ["g[0]", 0],
          ["g[1]", 1]
        ]).to eq(subject.flatten_params(params))
      end
    end
  end

  describe "#normalize_params " do
    context "should reject nil keys" do
      it do
        expect { subject.normalize_params(nil) }.to raise_error(TypeError)
      end
    end
  end

  describe "#normalize_headers" do
    context "normalize the format of a header key" do
      it do
        expect({"Request-Id" => nil}).to eq(
          subject.normalize_headers("Request-Id" => nil)
        )
        expect({"Request-Id" => nil}).to eq(
          subject.normalize_headers("request-id" => nil)
        )
        expect({"Request-Id" => nil}).to eq(
          subject.normalize_headers("Request-ID" => nil)
        )
        expect({"Request-Id" => nil}).to eq(
          subject.normalize_headers(request_id: nil)
        )
      end
    end

    context "tolerate bad formatting" do
      it do
        expect({"Request-Id" => nil}).to eq(
          subject.normalize_headers("-Request--Id-" => nil)
        )
        expect({"Request-Id" => nil}).to eq(
          subject.normalize_headers(request__id: nil)
        )
      end
    end
  end
end
